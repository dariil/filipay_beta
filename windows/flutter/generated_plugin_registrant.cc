//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_windows.h>
#include <flutter_local_authentication/flutter_local_authentication_plugin_c_api.h>
#include <local_auth_windows/local_auth_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  FlutterLocalAuthenticationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterLocalAuthenticationPluginCApi"));
  LocalAuthPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("LocalAuthPlugin"));
}
