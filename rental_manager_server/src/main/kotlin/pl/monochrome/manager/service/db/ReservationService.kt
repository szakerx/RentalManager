package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.Reservation
import pl.monochrome.manager.model.dto.ReservationDto
import pl.monochrome.manager.repository.ReservationRepository

@Service
class ReservationService @Autowired constructor(
    private val reservationRepository: ReservationRepository,
    private val personService: PersonService,
    private val rentalObjectService: RentalObjectService,
    private val userService: UserService
) {

    @Autowired
    private lateinit var plannedMessageService: PlannedMessageService

    fun getReservationsForUser(userId: String) = reservationRepository.findAllByUserId(userId)

    fun addReservation(reservationDto: ReservationDto): Reservation {
        val reservation = dtoToObject(reservationDto)
        return reservationRepository.save(reservation)
    }

    fun updateReservation(reservationDto: ReservationDto): Reservation {
        val reservation = dtoToObject(reservationDto)
        return reservationRepository.save(reservation)
    }

    fun getReservation(reservationId: Int): Reservation {
        return reservationRepository.findById(reservationId).get()
    }

    fun deleteReservation(reservationId: Int) {
        val plannedMessages = reservationRepository.getAllPlannedMessages(reservationId)
        plannedMessages.forEach { plannedMessageService.deletePlannedMessage(it.id) }
        reservationRepository.deleteById(reservationId)
    }

    private fun dtoToObject(reservationDto: ReservationDto): Reservation {
        val person = personService.getPerson(reservationDto.personId)
        val rentalObject = rentalObjectService.getRentalObject(reservationDto.rentalObjectId)
        val user = userService.getUserById(reservationDto.userId)
        return Reservation(
            reservationDto.id,
            reservationDto.startDate,
            reservationDto.endDate,
            reservationDto.description,
            reservationDto.guestsCount,
            reservationDto.childrenCount,
            reservationDto.price,
            person,
            rentalObject,
            user
        )
    }
}