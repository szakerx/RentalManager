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

    @Column
    val maxGuests: Int,

    @Column
    val description: String,

    @Column
    val name: String,

    @Column
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    val type: ObjectType,

    @Column
    val allowedAnimals: Boolean,

    @ManyToOne
    val user: User

)