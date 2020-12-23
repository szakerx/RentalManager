package pl.monochrome.manager.model.database

import org.hibernate.annotations.Type
import org.hibernate.annotations.TypeDef
import pl.monochrome.manager.model.enums.PostgresqlEnumType
import pl.monochrome.manager.model.enums.ObjectType
import javax.persistence.*

@Entity
@TypeDef(
    name = "pgsql_enum",
    typeClass = PostgresqlEnumType::class
)
@Table(name = "Rental_objects")
data class RentalObject(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Int,

    @Column //(name = "max_guests")
    val maxGuest: Int,

    @Column
    val description: String,

    @Column
    val name: String,

    @Column
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    val type: ObjectType,

    @Column //(name = "allowed_animals")
    val allowedAnimals: Boolean,

    @ManyToOne
    val user: User?
)