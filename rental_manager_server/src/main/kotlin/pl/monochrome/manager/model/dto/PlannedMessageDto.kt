package pl.monochrome.manager.model.dto

import pl.monochrome.manager.model.enums.Target
import java.time.LocalDateTime

data class PlannedMessageDto(
    val id: Int,
    val sendingTime: LocalDateTime,
    val target: Target,
    val messageSchemeId: Int,
    val reservationId: Int
)
