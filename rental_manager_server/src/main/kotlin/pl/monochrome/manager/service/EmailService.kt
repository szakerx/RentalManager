package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.stereotype.Service

@Service
class EmailService @Autowired constructor(private val emailSender: JavaMailSender) {

    fun sendMessage(to: String, subject: String, text: String) {
        val simpleMailMessage = SimpleMailMessage()
        simpleMailMessage.setFrom("monochrome.dolphins@gmail.com")
        simpleMailMessage.setTo(to)
        simpleMailMessage.setSubject(subject)
        simpleMailMessage.setText(text)
        emailSender.send(simpleMailMessage)
    }

}