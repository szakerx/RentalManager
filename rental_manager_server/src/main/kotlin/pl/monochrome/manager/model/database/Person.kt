package pl.monochrome.manager.model.database

import javax.persistence.*

@Entity
@Table(name = "people")
data class Person(

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: Int = -1,

        @Column
        val name: String = "Default",

        @Column
        val surname: String = "User",

        @Column
        val phone: String? = null,

        @Column
        val mail: String? = null

)