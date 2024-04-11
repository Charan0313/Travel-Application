const mongoose = require('mongoose')
const fs = require('fs')

const BusModel = require('../models/bus')
const BusDetailsModel = require('../models/busDetails')
const OwnerModel = require('../models/ownerDetails')
const StaffModel = require('../models/staff')
const UserModel = require('../models/user')
const AddressModel = require('../models/address')
const SeatModel = require('../models/seat')
const StopModel = require('../models/stop')

const { Owner } = require('../utils/enumTypes')
const { busS3Url, allowedFileTypes } = require('../utils/constants')

exports.createBus = async (req, res) => {
    try {
        const { name, number, seatCapacity, sourceStop, destinationStop, parkingAddress, busDetails } = req.body;
        const { street, city, state, country, pinCode } = parkingAddress;
        const { busType, capacity, fuelType, fuelCapacity } = busDetails;
        const { certificates } = req.files;

        if (!name || !number || !seatCapacity || !sourceStop || !destinationStop || !parkingAddress || !stops || !busDetails) {
            return res.status(400).json({
                success: false,
                message: "Please give required details"
            })
        }

        if (!busType || !capacity || !certificates || !fuelType || !fuelCapacity) {
            return res.status(400).json({
                success: false,
                message: "Please give required bus details"
            })
        }

        if (!street || !city || !state || !country || !pinCode) {
            return res.status(400).json({
                success: false,
                message: "Please give required parking address details"
            })
        }

        const numberPattern = /^[A-Za-z]{2}\s\d{2}\s[A-Za-z]{2}\s\d{4}$/;
        if (!numberPattern.test(number)) {
            return res.status(400).json({
                success: false,
                message: "Registration Number of the Bus doen't follow the norms",
            })
        }

        const { id } = req.user;

        const user = await UserModel.findById(id);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: "User Not Found"
            })
        }

        if (user.accountType != Owner) {
            return res.status(400).json({
                success: false,
                message: "You are not an owner"
            })
        }

        const owner = await OwnerModel.findById(user.ownerDetails);
        if (!owner) {
            return res.status(404).json({
                success: false,
                message: "Owner Not Found"
            })
        }

        const addressInstance = await AddressModel.create({
            street, city, state, country, pinCode
        })

        const certificatesArray = [];
        for (const certificate of certificates) {
            const filePath = `${busS3Url}/${id}/${certificate.name}`;
            const fileStream = fs.createReadStream(certificate.tempFilePath);

            if (!fileStream) {
                return res.status(404).json({
                    success: false,
                    message: "Failed to upload certificate"
                })
            }

            if (!allowedFileTypes.includes(certificate.mimetype)) {
                return res.status(400).json({
                    success: false,
                    message: "Invalid File Type"
                })
            }

            await uploadImageToS3_Type2({
                filePath: filePath,
                contentType: certificate.mimetype,
                body: fileStream
            })

            const imageUrl = await getObjectUrl(filePath)

            if (!imageUrl) {
                return res.status(404).json({
                    success: false,
                    message: "Failed to upload certificate"
                })
            }

            certificatesArray.push(imageUrl);
        }


        const busDetailsInstance = await BusDetailsModel.create({
            busType, capacity, certificates: certificatesArray, fuelType, fuelCapacity
        });

        const busInstance = await BusModel.create({
            name,
            number,
            seatCapacity,
            sourceStop,
            destinationStop,
            parkingAddress: addressInstance._id,
            busDetails: busDetailsInstance._id
        })

        busDetailsInstance.busId = busInstance._id;

        await busDetailsInstance.save();
        await busInstance.save();

        // const seatsArray = [];

        // for(let i=1;i<=seatCapacity; i++){
        //     const seat = await SeatModel.create({
        //         number: i,
        //         busId: busInstance._id,
        //     })

        //     seatsArray.push(seat);
        // }

        // busInstance.seats = seatsArray;
        // await busInstance.save();

        return res.status(201).json({
            success: true,
            message: "Bus Created Successfully",
            bus: busInstance,
            busDetails,
            address: addressInstance
        });

    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            error: error.message,
            message: "An Error Occurred While Creating Bus",
        })
    }
}

exports.getBuses = async (req, res) => {
    try {
        const buses = await BusModel.find().populate('sourceStop').populate('destinationStop').populate('stops').populate('parkingAddress').populate('busDetails').populate('seats');

        if (!buses) {
            return res.status(400).json({
                success: true,
                message: "No Buses Found",
            });
        }

        return res.status(200).json({
            success: true,
            message: "Buses Fetched Successfully",
            buses,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Fetching Buses",
            error: error.message,
        })
    }
}

exports.getBus = async (req, res) => {
    try {
        const { id } = req.body || req.params || req.query;
        if (!id) {
            return res.status(400).json({
                success: false,
                message: "Bus ID is Required",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({
                success: false,
                message: "Invalid Bus ID",
            });
        }

        const bus = await BusModel.findById(id).populate('sourceStop').populate('destinationStop').populate('stops').populate('parkingAddress').populate('busDetails').populate('seats');

        return res.status(200).json({
            success: true,
            message: "Bus Fetched Successfully",
            bus,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Fetching Bus",
            error: error.message,
        })
    }
}

//? Seats Controllers for Bus

exports.createSeats = async (req, res) => {
    try {
        const { seatCapacity, seatArray } = req.body;
        const { busId } = req.params || req.query;
        const { id } = req.user;
        if (!busId || !seatCapacity || !seatArray) {
            return res.status(400).json({
                success: false,
                message: "Please give required details",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(busId)) {
            return res.status(404).json({
                success: false,
                message: "Invalid Bus ID",
            })
        }

        const user = await UserModel.findById(id);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: "User Not Found",
            })
        }

        if (user.accountType != Owner) {
            return res.status(400).json({
                success: false,
                message: "You are not an owner",
            })
        }


        const bus = await BusModel.findById(busId);
        if (!bus) {
            return res.status(404).json({
                success: false,
                message: "Bus Not Found",
            })
        }

        if (bus.ownerId.toString() != id) {
            return res.status(400).json({
                success: false,
                message: "You are not the owner of the bus",
            })
        }

        const seatsArray = [];
        for (var seat in seatArray) {
            const { number, seatPlace, seatType } = seat;
            if (!number || !seatPlace || !seatType) {
                return res.status(400).json({
                    success: false,
                    message: "Please give required seat details",
                });
            }
            const seatInstance = await SeatModel.create(
                {
                    number: number,
                    seatPlace: seatPlace,
                    seatType: seatType,
                    busId
                }
            )

            seatsArray.push(seatInstance);
        }

        bus.seats = seatsArray;
        bus.seatCapacity = seatCapacity;
        await bus.save();

        return res.status(201).json({
            success: true,
            message: "Seats Created Successfully",
            seats: seatsArray,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Creating Seats",
            error: error.message,
        })
    }
}

exports.getSeats = async (req, res) => {
    try {
        const { busId } = req.params || req.query;
        if (!busId) {
            return res.status(400).json({
                success: false,
                message: "Please give required details",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(busId)) {
            return res.status(404).json({
                success: false,
                message: "Invalid Bus ID",
            })
        }

        const bus = await BusModel.findById(busId).populate('seats').exec();
        if (!bus) {
            return res.status(404).json({
                success: false,
                message: "Bus Not Found",
            })
        }

        return res.status(200).json({
            success: true,
            message: "Seats Fetched Successfully",
            bus,
            seats: bus.seats,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Fetching Seats",
            error: error.message,
        })
    }
}


exports.editSeats = async (req, res) => {
    try {
        const { seatCapacity, seatArray } = req.body;
        const { busId } = req.params || req.query;
        const { id } = req.user;
        if (!busId || !seatCapacity || !seatArray) {
            return res.status(400).json({
                success: false,
                message: "Please give required details",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(busId)) {
            return res.status(404).json({
                success: false,
                message: "Invalid Bus ID",
            })
        }

        const user = await UserModel.findById(id);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: "User Not Found",
            })
        }

        if (user.accountType != Owner) {
            return res.status(400).json({
                success: false,
                message: "You are not an owner",
            })
        }

        const bus = await BusModel.findById(busId);
        if (!bus) {
            return res.status(404).json({
                success: false,
                message: "Bus Not Found",
            })
        }

        if (bus.ownerId.toString() != id) {
            return res.status(400).json({
                success: false,
                message: "You are not the owner of the bus",
            })
        }

        for (var seatId in bus.seats) {
            await SeatModel.deleteOne({ _id: seatId });
        }

        const seatsArray = [];
        for (var seat in seatArray) {
            const { number, seatPlace, seatType } = seat;
            if (!number || !seatPlace || !seatType) {
                return res.status(400).json({
                    success: false,
                    message: "Please give required seat details",
                });
            }
            const seatInstance = await SeatModel.create(
                {
                    number: number,
                    seatPlace: seatPlace,
                    seatType: seatType,
                    busId
                }
            )

            seatsArray.push(seatInstance);
        }

        bus.seats = seatsArray;
        bus.seatCapacity = seatCapacity;
        await bus.save();

        return res.status(200).json({
            success: true,
            message: "Seats Edited Successfully",
            seats: seatsArray,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Editing Seats",
            error: error.message,
        })
    }
}

//! Stop Controllers for Bus

exports.addStops = async (req, res) => {
    try {
        const { stops } = req.body;
        const { busId } = req.params || req.query;
        const { id } = req.user;

        if (!stops || !busId) {
            return res.status(400).json({
                success: false,
                message: "Please give required details",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(busId)) {
            return res.status(404).json({
                success: false,
                message: "Invalid Bus ID",
            })
        }

        const user = await UserModel.findById(id);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: "User Not Found",
            })
        }

        if (user.accountType != Owner) {
            return res.status(400).json({
                success: false,
                message: "You are not an owner",
            })
        }

        const bus = await BusModel.findById(busId);
        if (!bus) {
            return res.status(404).json({
                success: false,
                message: "Bus Not Found",
            })
        }

        if (bus.ownerId.toString() != id) {
            return res.status(400).json({
                success: false,
                message: "You are not the owner of the bus",
            })
        }

        const stopsArray = [];
        for (var stop in stops) {
            const stopInstance = await StopModel.findById(stop);
            if (!stopInstance) {
                return res.status(404).json({
                    success: false,
                    message: "Stop Not Found",
                })
            }

            stopsArray.push(stopInstance._id);
        }

        bus.stops = stopsArray;
        await bus.save();

        return res.status(201).json({
            success: true,
            message: "Stops Added Successfully",
            stops: stopsArray,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Adding Stops",
            error: error.message,
        })
    }
}

exports.getStops = async (req, res) => {
    try {
        const { busId } = req.params || req.query;
        // const {id} = req.user;

        if (!busId) {
            return res.status(400).json({
                success: false,
                message: "Please give required details",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(busId)) {
            return res.status(404).json({
                success: false,
                message: "Invalid Bus ID",
            })
        }

        const bus = await BusModel.findById(busId).populate('stops').exec();
        if (!bus) {
            return res.status(404).json({
                success: false,
                message: "Bus Not Found",
            })
        }

        return res.status(200).json({
            success: true,
            message: "Stops Fetched Successfully",
            bus,
            stops: bus.stops,
        });
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Fetching Stops",
            error: error.message,
        })
    }
}

exports.editStops = async (req, res) => {
    try {
        const { stops } = req.body;
        const { busId } = req.params || req.query;
        const { id } = req.user;
        if (!stops || !busId) {
            return res.status(400).json({
                success: false,
                message: "Please give required details",
            });
        }

        if (!mongoose.Types.ObjectId.isValid(busId)) {
            return res.status(404).json({
                success: false,
                message: "Invalid Bus ID",
            })
        }

        const user = await UserModel.findById(id);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: "User Not Found",
            })
        }

        if (user.accountType != Owner) {
            return res.status(400).json({
                success: false,
                message: "You are not an owner",
            })
        }

        if (user.ownerDetails.toString() != id) {
            return res.status(400).json({
                success: false,
                message: "You are not the owner of the bus",
            })
        }

        const bus = await BusModel.findById(busId);
        if (!bus) {
            return res.status(404).json({
                success: false,
                message: "Bus Not Found",
            })
        }

        const stopsArray = [];
        for (var stop in stops) {
            const stopInstance = await StopModel.findById(stop);
            if (!stopInstance) {
                return res.status(404).json({
                    success: false,
                    message: "Stop Not Found",
                })
            }
            stopsArray.push(stopInstance._id);
        }

        bus.stops = stopsArray;
        await bus.save();

        return res.status(200).json({
            success: true,
            message: "Stops Edited Successfully",
            stops: stopsArray,
            bus
        })
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            success: false,
            message: "An Error Occurred While Editing Stops",
            error: error.message,
        })
    }
}