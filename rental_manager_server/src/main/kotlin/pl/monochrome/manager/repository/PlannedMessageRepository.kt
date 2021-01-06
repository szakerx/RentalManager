package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import pl.monochrome.manager.model.database.PlannedMessage
import java.time.LocalDateTime

@Repository
interface PlannedMessageRepository : JpaRepository<PlannedMessage, Int> {

    fun findAllByReservationId(id: Int): Set<PlannedMessage>

    fun findAllBySendingTimeBetween(startDate: LocalDateTime, endDate: LocalDateTime): Set<PlannedMessage>

}