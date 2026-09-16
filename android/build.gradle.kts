allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            val android = project.extensions.findByName("android")
            try {
                // Forcing compileSdk to 36 (required by newer dependencies)
                val method = android?.javaClass?.getMethod("compileSdk", Int::class.java)
                method?.invoke(android, 36)
            } catch (e: Exception) {
            }
            
            project.dependencies.add("compileOnly", "org.checkerframework:checker-qual:3.49.0")
        }
    }
}

subprojects {
    if (project.name != "app") {
        project.evaluationDependsOn(":app")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
