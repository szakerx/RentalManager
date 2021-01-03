package pl.monochrome.manager.model.database

import javax.persistence.*

@Entity
@Table(name = "people")
data class Person(

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        @Column
        val name: String,

        @Column
        val surname: String,

        @Column
        val phone: String?,

        @Column
        val mail: String?

)