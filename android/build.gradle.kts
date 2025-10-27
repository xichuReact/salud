import com.android.build.gradle.LibraryExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withId("com.android.library") {
        extensions.configure<LibraryExtension>("android") {
            // Fuerza compileSdkVersion=34 para librerías heredadas como isar_flutter_libs.
            @Suppress("DEPRECATION")
            compileSdkVersion(34)
            val currentNamespace = namespace
            if (currentNamespace.isNullOrBlank()) {
                val groupId = project.group.toString().takeUnless { it.isBlank() || it == "unspecified" }
                val candidate = listOfNotNull(groupId, project.name)
                    .joinToString(separator = ".")
                    .replace('-', '_')
                namespace = candidate
            }
        }
    }

    if (project.name == "isar_flutter_libs") {
        val manifestFile = project.file("src/main/AndroidManifest.xml")
        if (manifestFile.exists()) {
            val original = manifestFile.readText()
            val updated = original.replace(Regex("\\s+package=\"[^\"]+\""), "")
            if (original != updated) {
                manifestFile.writeText(updated)
            }
        }
        val moduleBuildFile = project.file("build.gradle")
        if (moduleBuildFile.exists()) {
            val original = moduleBuildFile.readText()
            val updated = original
                .replace("classpath 'com.android.tools.build:gradle:7.3.1'", "classpath 'com.android.tools.build:gradle:8.6.1'")
                .replace(Regex("compileSdkVersion\\s+\\d+"), "compileSdkVersion 34")
            if (original != updated) {
                moduleBuildFile.writeText(updated)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
