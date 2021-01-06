package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import pl.monochrome.manager.model.database.PlannedMessage
import pl.monochrome.manager.model.database.Reservation

@Repository
interface ReservationRepository: JpaRepository<Reservation, Int> {

    fun findAllByUserId(userId: String): Set<Reservation>

    @Query("SELECT pm FROM PlannedMessage pm WHERE pm.reservation.id = :reservationId")
    fun getAllPlannedMessages(@Param("reservationId") reservationId: Int): Set<PlannedMessage>

}