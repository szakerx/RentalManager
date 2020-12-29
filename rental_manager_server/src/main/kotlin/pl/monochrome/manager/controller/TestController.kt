package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import pl.monochrome.manager.service.EmailService

@RestController
@RequestMapping("/test")
class TestController @Autowired constructor(private val emailService: EmailService) {
    @GetMapping("/email")
    fun sendEmail() {
        println("Sending email...")
        emailService.sendMessage(
            "hubert.wawrzacz@gmail.com",
            "Test Kotlin Spring Mail",
            "Witam szanownego Huberta z mojej aplikacji :)"
        )
        println("Email sent!")
    }
}