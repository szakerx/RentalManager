package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.MessageScheme
import pl.monochrome.manager.model.dto.MessageSchemeDto
import pl.monochrome.manager.repository.MessageSchemaRepository

@Service
class MessageSchemeService @Autowired constructor(
    private val repository: MessageSchemaRepository,
    private val userService: UserService
) {

    fun getAllSchemasForUser(userId: String): Set<MessageScheme> = repository.findAllByUserId(userId)

    fun getMessageScheme(messageSchemeId: Int) = repository.findById(messageSchemeId)

    fun addMessageScheme(messageSchemaDto: MessageSchemeDto): MessageScheme {
        val messageScheme = dtoToObject(messageSchemaDto)
        return repository.save(messageScheme)
    }

    fun updateMessageScheme(messageSchemaDto: MessageSchemeDto): MessageScheme {
        val messageScheme = dtoToObject(messageSchemaDto)
        return repository.save(messageScheme)
    }

    fun deleteMessageScheme(messageSchemeId: Int) = repository.deleteById(messageSchemeId)

    private fun dtoToObject(messageSchemaDto: MessageSchemeDto): MessageScheme {
        val user = userService.getUserById(messageSchemaDto.userId)
        return MessageScheme(messageSchemaDto.id, messageSchemaDto.name, messageSchemaDto.content, user)
    }

}