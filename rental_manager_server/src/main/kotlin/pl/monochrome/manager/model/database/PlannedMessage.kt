package pl.monochrome.manager.model.database

import org.hibernate.annotations.Type
import org.hibernate.annotations.TypeDef
import pl.monochrome.manager.model.enums.PostgresqlEnumType
import pl.monochrome.manager.model.enums.Target
import java.time.LocalDateTime
import javax.persistence.*

@Entity
@TypeDef(
    name = "pgsql_enum",
    typeClass = PostgresqlEnumType::class
)
@Table(name = "planned_messages")
data class PlannedMessage(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Int,

    @Column
    val sendingTime: LocalDateTime,

    @Column
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    val target: Target,

    @ManyToOne
    val messageScheme: MessageScheme,

    @ManyToOne
    val reservation: Reservation
)