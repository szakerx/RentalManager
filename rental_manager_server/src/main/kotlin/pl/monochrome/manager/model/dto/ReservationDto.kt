package pl.monochrome.manager.model.dto

import java.math.BigDecimal
import java.time.LocalDateTime

data class ReservationDto(
    val id: Int,
    val startDate: LocalDateTime,
    val endDate: LocalDateTime,
    val description: String?,
    val guestsCount: Int,
    val childrenCount: Int,
    val price: BigDecimal,
    val personId: Int,
    val rentalObjectId: Int,
    val userId: String
)
