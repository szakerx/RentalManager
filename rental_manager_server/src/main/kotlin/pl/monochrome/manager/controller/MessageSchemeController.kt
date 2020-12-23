package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.database.MessageScheme
import pl.monochrome.manager.model.dto.MessageSchemeDTO
import pl.monochrome.manager.service.MessageSchemeService
import java.util.*

@RestController
@RequestMapping("/schemes")
class MessageSchemeController @Autowired constructor(private val service: MessageSchemeService) {

    @GetMapping
    fun getAllMessageSchemes(@RequestParam userId: String) = service.getAllSchemasForUser(userId)

    @GetMapping("/{id}")
    fun getMessageSchema(@PathVariable("id") messageSchemeId: Int) = service.getMessageScheme(messageSchemeId)

    @PostMapping
    fun addMessageScheme(@RequestParam userId: String, @RequestBody messageSchemeDTO: MessageSchemeDTO): MessageScheme {
        return service.addMessageScheme(messageSchemeDTO, userId)
    }

    @DeleteMapping("/{id}")
    fun deleteMessageScheme(@RequestBody messageSchemeDTO: MessageSchemeDTO): ResponseEntity<String> {
        service.deleteMessageScheme(messageSchemeDTO)
        return ResponseEntity(HttpStatus.OK)
    }
}