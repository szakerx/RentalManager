package pl.monochrome.manager.security

import com.google.auth.oauth2.GoogleCredentials
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseAuthException
import org.slf4j.LoggerFactory
import org.springframework.core.env.Environment
import java.io.FileInputStream
import javax.servlet.FilterChain
import javax.servlet.http.HttpFilter
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class FirebaseAuthenticationFilter(environment: Environment) : HttpFilter() {

    private val logger = LoggerFactory.getLogger(FirebaseAuthenticationFilter::class.java)

    init {
        val serviceAccount = FileInputStream(environment.getRequiredProperty("firebase.service.key.path"))
        val options = FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.fromStream(serviceAccount))
            .setDatabaseUrl("https://rentalmanager-9f506.firebaseio.com")
            .build()
        FirebaseApp.initializeApp(options)
    }

    override fun doFilter(request: HttpServletRequest?, response: HttpServletResponse?, chain: FilterChain?) {
        val authenticationToken = request?.getHeader("Authorization")?.drop(7)
        if (authenticationToken.isNullOrEmpty()) {
            logger.info("Token null/empty")
            response?.status = HttpServletResponse.SC_UNAUTHORIZED
            return
        } else {
            try {
                logger.info("Trying to authenticate token")
                FirebaseAuth.getInstance().verifyIdToken(authenticationToken)
                chain?.doFilter(request, response)
                logger.info("Token authorized")
            } catch (exception: FirebaseAuthException) {
                logger.info("Token unauthorized")
                response?.status = HttpServletResponse.SC_UNAUTHORIZED
                return
            }
        }
    }
}