package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.web.bind.annotation.RequestParam
import pl.monochrome.manager.model.database.PlannedMessage
import pl.monochrome.manager.repository.PlannedMessageRepository

@Service
class PlannedMessageService @Autowired constructor(private val repository: PlannedMessageRepository) {

    fun getPlannedMessagesForReservation(reservationId: Int) = repository.findAllByReservationId(reservationId)

    fun getPlannedMessageById(plannedMessageId: Int): PlannedMessage = repository.findById(plannedMessageId).get()

}