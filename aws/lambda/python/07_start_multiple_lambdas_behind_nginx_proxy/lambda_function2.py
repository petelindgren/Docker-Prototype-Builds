import sys
def handler(event, context):
    return {
        "lambda": "Lambda2 example #07",
        "python_version": sys.version,
        "docker_image": "AWS Base Image",
        "has_runtime_interface_emulator": True,
        "has_docker_entrypoint": True,
        "uses_docker_compose": True,
    }
