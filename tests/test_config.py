"""Comprueba el YAML de Compose que despliega el laboratorio."""
from pathlib import Path
import unittest
import yaml

COMPOSE = Path(__file__).resolve().parents[1] / "docker/docker-compose.yml"


class ConfigTest(unittest.TestCase):
    def test_compose_yaml(self):
        with COMPOSE.open(encoding="utf-8") as source:
            config = yaml.safe_load(source)
        self.assertIsInstance(config, dict)
        self.assertEqual(set(config["services"]), {"web_server", "log_analyzer"})


if __name__ == "__main__":
    unittest.main()
