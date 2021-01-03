package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.PlannedMessageDto
import pl.monochrome.manager.service.db.PlannedMessageService

@RestController
@RequestMapping("/plannedmessages")
class PlannedMessageController @Autowired constructor(private val service: PlannedMessageService) {

    @GetMapping("/{id}")
    fun getPlannedMessage(@PathVariable plannedMessageId: Int) = service.getPlannedMessageById(plannedMessageId)

    @PostMapping
    fun addPlannedMessage(@RequestBody plannedMessageDto: PlannedMessageDto) = service.addPlannedMessage(plannedMessageDto)

    @DeleteMapping("/{id}")
    fun deletePlannedMessage(@PathVariable plannedMessageId: Int) = service.deletePlannedMessage(plannedMessageId)

    @PutMapping
    fun updatePlannedMessage(@RequestBody plannedMessageDto: PlannedMessageDto) = service.updatePlannedMessage(plannedMessageDto)

    @GetMapping
    fun getAllPlannedMessagesByReservationId(@RequestParam reservationId: Int) = service.getPlannedMessagesForReservation(reservationId)
}