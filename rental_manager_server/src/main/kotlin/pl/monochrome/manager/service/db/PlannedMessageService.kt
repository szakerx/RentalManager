package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.PlannedMessage
import pl.monochrome.manager.model.dto.PlannedMessageDto
import pl.monochrome.manager.repository.PlannedMessageRepository
import java.time.LocalDateTime

@Service
class PlannedMessageService @Autowired constructor(
    private val repository: PlannedMessageRepository,
    private val messageSchemeService: MessageSchemeService
) {

    @Autowired
    private lateinit var reservationService: ReservationService

    fun getPlannedMessagesForReservation(reservationId: Int) = repository.findAllByReservationId(reservationId)

    fun getPlannedMessageById(plannedMessageId: Int): PlannedMessage = repository.findById(plannedMessageId).get()

    fun addPlannedMessage(plannedMessageDto: PlannedMessageDto): PlannedMessage {
        val plannedMessage = dtoToObject(plannedMessageDto)
        return repository.save(plannedMessage)
    }

    fun updatePlannedMessage(plannedMessageDto: PlannedMessageDto): PlannedMessage {
        val messageScheme = dtoToObject(plannedMessageDto)
        return repository.save(messageScheme)
    }

    fun deletePlannedMessage(plannedMessageId: Int) = repository.deleteById(plannedMessageId)

    fun getAllPlannedMessagesBetweenDates(startTime: LocalDateTime, endTime: LocalDateTime) =
        repository.findAllBySendingTimeBetween(startTime, endTime)

    private fun dtoToObject(plannedMessageDto: PlannedMessageDto): PlannedMessage {
        val messageScheme = messageSchemeService.getMessageScheme(plannedMessageDto.messageSchemeId).get()
        val reservation = reservationService.getReservation(plannedMessageDto.reservationId)
        return PlannedMessage(
            plannedMessageDto.id,
            plannedMessageDto.sendingTime,
            plannedMessageDto.target,
            messageScheme,
            reservation
        )
    }

}