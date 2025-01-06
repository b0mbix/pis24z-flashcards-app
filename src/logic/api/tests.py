from django.test import TestCase

class SimpleTest(TestCase):

    def test_one_equals_one(self):
        # Test sprawdzający, czy 1 == 1
        self.assertEqual(1, 1)

