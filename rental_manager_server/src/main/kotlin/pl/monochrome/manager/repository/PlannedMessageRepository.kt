package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import pl.monochrome.manager.model.database.PlannedMessage

@Repository
interface PlannedMessageRepository: JpaRepository<PlannedMessage, Int> {
    fun findAllByReservationId(id: Int): Set<PlannedMessage>
}