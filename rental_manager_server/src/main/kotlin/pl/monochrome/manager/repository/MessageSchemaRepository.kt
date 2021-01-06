package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.MessageScheme

interface MessageSchemaRepository: JpaRepository<MessageScheme, Int> {

    fun findAllByUserId(userId: String): Set<MessageScheme>

}