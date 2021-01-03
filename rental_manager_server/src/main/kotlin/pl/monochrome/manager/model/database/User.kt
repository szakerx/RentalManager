package pl.monochrome.manager.model.database

import javax.persistence.*

@Entity
@Table(name = "users")
data class User(
        @Id
        val id: String = ""
)