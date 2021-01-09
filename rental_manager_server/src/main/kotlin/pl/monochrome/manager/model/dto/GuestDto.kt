package pl.monochrome.manager.model.dto

import pl.monochrome.manager.model.database.Person

data class GuestDto(
    val userId: String,
    var person: Person,
    val note: String
)