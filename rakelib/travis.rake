# Copyright 2014 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

desc "Run the build for travis-ci."
task :travis do
  Rake::Task["rubocop"].invoke
  Rake::Task["test"].invoke

  if ENV["TRAVIS_BRANCH"] == "master" &&
     ENV["TRAVIS_PULL_REQUEST"] == "false"
    puts ""
    echo "Preparing to run regression tests."
    puts ""
    # Decrypt the keyfile
    `openssl aes-256-cbc -K $encrypted_629ec55f39b2_key -iv $encrypted_629ec55f39b2_iv -in keyfile.json.enc -out keyfile.json -d`

    Rake::Task["test:regression"].invoke
  else
    puts ""
    puts "Skipping regression tests."
    puts ""
  end
end
