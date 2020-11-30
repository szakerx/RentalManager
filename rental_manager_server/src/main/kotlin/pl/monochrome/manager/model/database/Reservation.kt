package pl.monochrome.manager.model.database

import java.time.LocalDateTime
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "reservations")
data class Reservation(

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: UUID,

        @Column
        val startDate: LocalDateTime,

        @Column
        val endDate: LocalDateTime,

        @Column
        val description: String?,

        @Column
        val guests_count: Int,

        @Column
        val children_count: Int,

        @ManyToOne
        val person: Person,

        @ManyToOne
        val rentalObject: RentalObject,

        @ManyToOne
        val user: User
)