package pl.monochrome.manager.model.database

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "users")
data class User(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: UUID? = UUID.randomUUID()
)