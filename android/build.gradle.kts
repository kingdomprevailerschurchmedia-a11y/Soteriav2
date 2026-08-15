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

// Force all subprojects (including flutter_native_splash) to compile against SDK 35
subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            project.extensions.findByName("android")?.let { android ->
                try {
                    val compileSdkProp = android.javaClass.getMethod("getCompileSdk")
                    val currentSdk = compileSdkProp.invoke(android) as? Int
                    if (currentSdk == null || currentSdk < 35) {
                        val setCompileSdkMethod = android.javaClass.getMethod("compileSdk", Int::class.java)
                        setCompileSdkMethod.invoke(android, 35)
                    }
                } catch (e: Exception) {
                    // Ignore if extension doesn't match
                }
            }
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