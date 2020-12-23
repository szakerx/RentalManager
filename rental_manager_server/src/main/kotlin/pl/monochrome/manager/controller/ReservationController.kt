package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.ReservationDto
import pl.monochrome.manager.service.ReservationService

@RestController
@RequestMapping("/reservations")
class ReservationController @Autowired constructor(private val reservationService: ReservationService) {

    @GetMapping
    fun getReservationsForUser(@RequestParam userId: String) = reservationService.getReservationsForUser(userId)

    @PostMapping
    fun addReservation(@RequestBody reservationDto: ReservationDto) = reservationService.addReservation(reservationDto)

    @PutMapping
    fun updateReservation(@RequestBody reservationDto: ReservationDto) = reservationService.updateReservation(reservationDto)

    @GetMapping("/{id}")
    fun getReservation(@PathVariable id: Int) = reservationService.getReservation(id)

    @DeleteMapping("/{id}")
    fun deleteReservation(@PathVariable id: Int) = reservationService.deleteReservation(id)

}