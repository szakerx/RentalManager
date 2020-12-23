package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.MessageScheme
import pl.monochrome.manager.model.dto.MessageSchemeDTO
import pl.monochrome.manager.repository.MessageSchemaRepository

@Service
class MessageSchemeService @Autowired constructor(
    private val messageSchemaRepository: MessageSchemaRepository,
    private val userService: UserService
) {

    fun getAllSchemasForUser(userId: String): Set<MessageScheme> = messageSchemaRepository.findByUser_Id(userId)

    fun getMessageScheme(messageSchemeId: Int) = messageSchemaRepository.findByIdOrNull(messageSchemeId)

    fun addMessageScheme(messageSchemaDTO: MessageSchemeDTO, userId: String): MessageScheme {
        val user = userService.getUser(userId)
        val messageScheme = MessageScheme(messageSchemaDTO.id, messageSchemaDTO.name, messageSchemaDTO.content, user)
        return messageSchemaRepository.save(messageScheme)
    }

    fun deleteMessageScheme(messageSchemaDTO: MessageSchemeDTO) {
        return messageSchemaRepository.deleteById(messageSchemaDTO.id)
    }
}