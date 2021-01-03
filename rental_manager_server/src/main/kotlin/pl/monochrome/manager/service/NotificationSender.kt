package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import pl.monochrome.manager.service.db.PlannedMessageService
import java.time.LocalDateTime

@Service
class NotificationSender @Autowired constructor(
    private val emailService: EmailService,
    private val plannedMessageService: PlannedMessageService
) {

//    private var latestId: Int

    init {
//        latestId = 3
    }

    @Scheduled(fixedRateString = "PT1H")
    fun sendMessages() {
        // TODO: GET MESSAGES FROM DB AND SEND EMAILS
    }
}
