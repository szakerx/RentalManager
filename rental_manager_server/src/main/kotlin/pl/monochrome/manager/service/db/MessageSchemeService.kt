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

    fun getAllSchemasForUser(userId: String): Set<MessageScheme> = repository.findByUser_Id(userId)

    fun getMessageScheme(messageSchemeId: Int) = repository.findById(messageSchemeId).get()

    fun addMessageScheme(messageSchemaDto: MessageSchemeDto): MessageScheme {
        val messageScheme = dtoToObject(messageSchemaDto)
        return repository.save(messageScheme)
    }

    fun updateMessageScheme(messageSchemaDto: MessageSchemeDto): MessageScheme {
        val messageScheme = dtoToObject(messageSchemaDto)
        return repository.save(messageScheme)
    }

    fun deleteMessageScheme(messageSchemaDto: MessageSchemeDto) {
        return repository.deleteById(messageSchemaDto.id)
    }

    private fun dtoToObject(messageSchemaDto: MessageSchemeDto): MessageScheme {
        val user = userService.getUserById(messageSchemaDto.userId)
        return MessageScheme(messageSchemaDto.id, messageSchemaDto.name, messageSchemaDto.content, user)
    }
}