package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
class PlannedMessagesSendingService @Autowired constructor(private val emailService: EmailService) {
    @Scheduled(fixedRate = 1000)
    fun printSomething() = println(LocalDateTime.now())
}