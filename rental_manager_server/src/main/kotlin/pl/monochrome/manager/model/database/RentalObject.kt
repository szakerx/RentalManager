package pl.monochrome.manager.model.database

import pl.monochrome.manager.model.custom.ObjectType
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "Rental_objects")
data class RentalObject(

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: UUID = UUID.randomUUID(),

        @Column //(name = "max_guests")
        val maxGuests: Int = -1,

        @Column
        val description: String? = null,

        @Column
        val name: String = "default",

        @Column
        @Enumerated(EnumType.STRING)
        val type: ObjectType = ObjectType.HOUSE,

        @Column //(name = "allowed_animals")
        val allowedAnimals: Boolean = false,

        @ManyToOne
        val user: User?
)