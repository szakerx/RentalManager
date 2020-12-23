package pl.monochrome.manager.model.database

import java.math.BigDecimal
import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name = "reservations")
data class Reservation(

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: Int,

        @Column
        val startDate: LocalDateTime,

        @Column
        val endDate: LocalDateTime,

        @Column
        val description: String?,

        @Column
        val guestsCount: Int,

        @Column
        val childrenCount: Int,

        @Column
        val price: BigDecimal,

        @ManyToOne
        val person: Person,

        @ManyToOne
        val rentalObject: RentalObject,

        @ManyToOne
        val user: User
)