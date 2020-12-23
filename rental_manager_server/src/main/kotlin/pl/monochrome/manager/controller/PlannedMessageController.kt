package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.database.PlannedMessage
import pl.monochrome.manager.service.PlannedMessageService

@RestController
@RequestMapping("/plannedmessages")
class PlannedMessageController @Autowired constructor(private val service: PlannedMessageService) {

    @GetMapping
    fun getAllPlannedMessagesByReservationId(@RequestParam reservationId: Int): Set<PlannedMessage> {
        return service.getPlannedMessagesForReservation(reservationId)
    }

    @GetMapping("/{id}")
    fun getPlannedMessage(@PathVariable plannedMessageId: Int): PlannedMessage {
        return service.getPlannedMessageById(plannedMessageId)
    }
}