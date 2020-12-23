package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.MessageScheme
import java.util.*

interface MessageSchemaRepository: JpaRepository<MessageScheme, Int> {
    fun findByUser_Id(userId: String): Set<MessageScheme>
}