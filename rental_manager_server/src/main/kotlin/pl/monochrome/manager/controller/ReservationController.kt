package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.ReservationDto
import pl.monochrome.manager.service.db.ReservationService

@RestController
@RequestMapping("/reservations")
class ReservationController @Autowired constructor(private val reservationService: ReservationService) {

    @GetMapping
    fun getReservationsForUser(@RequestParam userId: String) = reservationService.getReservationsForUser(userId)

    @PostMapping
    fun addReservation(@RequestBody reservationDto: ReservationDto) = reservationService.addReservation(reservationDto)

    @PutMapping
    fun updateReservation(@RequestBody reservationDto: ReservationDto) = reservationService.updateReservation(reservationDto)

    @GetMapping("/{reservationId}")
    fun getReservation(@PathVariable reservationId: Int) = reservationService.getReservation(reservationId)

    @DeleteMapping("/{reservationId}")
    fun deleteReservation(@PathVariable reservationId: Int) = reservationService.deleteReservation(reservationId)

}