package pl.monochrome.manager.service

import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.enums.Target
import pl.monochrome.manager.service.db.PlannedMessageService
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Service
class NotificationSender @Autowired constructor(
    private val emailService: EmailService,
    private val plannedMessageService: PlannedMessageService
) {

    private val logger = LoggerFactory.getLogger(NotificationSender::class.java)

    private val dateTimeFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")

    @Scheduled(fixedRateString = "PT1H")
    fun sendMessages() {

        logger.info("Email service wake up.")

        val plannedMessages = plannedMessageService.getAllPlannedMessagesBetweenDates(
            LocalDateTime.now(),
            LocalDateTime.now().plusHours(1L)
        )
        plannedMessages.forEach { plannedMessage ->
            if (plannedMessage.target == Target.EMAIL || plannedMessage.target == Target.BOTH) {

                logger.info("Sending email for planned message of id: ${plannedMessage.id}")

                emailService.sendMessage(
                    plannedMessage.reservation.person.mail,
                    "Automatyczna wiadomość o rezerwacji: ${plannedMessage.reservation.startDate.format(dateTimeFormatter)}" +
                            " - ${plannedMessage.reservation.endDate.format(dateTimeFormatter)}",
                    plannedMessage.messageScheme.content
                )
            }
        }

        logger.info("Email service shut down.")

    }
}
