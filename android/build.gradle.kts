allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Force all subprojects to compile against a newer SDK
subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            val android = project.extensions.findByName("android")
            try {
                val method = android?.javaClass?.getMethod("compileSdk", Int::class.java)
                method?.invoke(android, 36)
            } catch (e: Exception) {
            }
            
            // Fix for "Type annotation class 'org.checkerframework.checker.initialization.qual.UnknownInitialization' is inaccessible"
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
