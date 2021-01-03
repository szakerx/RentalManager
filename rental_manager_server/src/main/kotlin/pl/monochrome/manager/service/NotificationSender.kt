package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Component
class TestSender constructor(private val dateTime: LocalDateTime){
    @Scheduled(fixedRateString = "PT1H")
    fun sendMessages() {
        // TODO: GET MESSAGES FROM DB AND SEND EMAILS
    }
}
