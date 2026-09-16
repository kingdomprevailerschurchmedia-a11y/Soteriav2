allprojects {
    repositories {
        google()
        mavenCentral()
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

tasks.register("printJavaVersion") {
    doLast {
        println("Java version: ${System.getProperty("java.version")}")
        println("Java home: ${System.getProperty("java.home")}")
    }
}
