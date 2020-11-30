package pl.monochrome.manager.model.database

import java.time.LocalDateTime
import java.util.*
import javax.persistence.*

data class PlannedMessage(

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: UUID,

        @Column
        val sendingTime: LocalDateTime,

        @Column
        val target: AnnotationTarget,

        @ManyToOne
        val messageScheme: MessageScheme,

        @ManyToOne
        val reservation: Reservation
)