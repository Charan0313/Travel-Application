const mongoose = require('mongoose')

const busSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        minlength: 2,
        maxlength: 50
    },
    number:{
        type: String,
        required: true,
        trim: true,
        minlength: 2,
        maxlength: 50
    },
    type: {
        
    },
    seatCapacity:{
        type: Number,
        required: true,
        trim: true,
    },
    seats: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Seat",
        }
    ],
    sourceStop: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Stop",
        required: true,
    },
    destinationStop: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Stop",
        required: true,
    },
    stops: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Stop"
        }
    ],
    parkingAddress:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Address",
        required: true,
    },
    staffId: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Staff",
        }
    ],
    ownerId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    busDetails: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "BusDetails",
        required: true,
    },
})

module.exports = mongoose.model('Bus', busSchema)