package pl.monochrome.manager.model.dto

import pl.monochrome.manager.model.enums.ObjectType

data class RentalObjectDto(
    val id: Int,
    val maxGuests: Int,
    val description: String,
    val name: String,
    val type: ObjectType,
    val allowedAnimals: Boolean,
    val userId: String
)
