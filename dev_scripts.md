## IOS Deployment
flutter build ipa

## Integration Tests
### Firebase Realtime DB Test
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/firebase_realtime_db_test.dart