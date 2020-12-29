package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import pl.monochrome.manager.model.database.Reservation

@Repository
interface ReservationRepository: JpaRepository<Reservation, Int> {
    fun findAllByUserId(userId: String): Set<Reservation>
}