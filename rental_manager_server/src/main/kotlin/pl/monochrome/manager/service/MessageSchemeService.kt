package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.MessageScheme
import pl.monochrome.manager.model.dto.MessageSchemeDTO
import pl.monochrome.manager.repository.MessageSchemaRepository
import java.util.*

@Service
class MessageSchemeService @Autowired constructor(private val messageSchemaRepository: MessageSchemaRepository,
                                                  private val userService: UserService) {
    fun getAllSchemasForUser(userId: UUID): Set<MessageScheme> = messageSchemaRepository.findByUser_Id(userId)

    fun getMessageScheme(messageSchemeId: UUID) = messageSchemaRepository.findByIdOrNull(messageSchemeId)

    fun addMessageScheme(messageSchemaDTO: MessageSchemeDTO) {
        val user = userService.findUser(messageSchemaDTO.userId)
        
        messageSchemaRepository.
    }
}