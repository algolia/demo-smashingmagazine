require_relative '../spec_helper'

describe(HelperPath) do
  describe 'sanitize' do
    it 'replaces any special char with an underscore' do
      # Given
      input = 'foo?bar.html'

      # When
      actual = HelperPath.sanitize(input)

      # Then
      expect(actual).to eq 'foo_bar.html'
    end
    it 'keep slash directory structure intact' do
      # Given
      input = 'foo/bar?baz.html'

      # When
      actual = HelperPath.sanitize(input)

      # Then
      expect(actual).to eq 'foo/bar_baz.html'
    end
  end

  describe 'camelize' do
    it 'transform an underscore_string to camelCalse' do
      # Given
      input = 'foo_bar'

      # When
      actual = HelperPath.camelize(input)

      # Then
      expect(actual).to eq 'fooBar'
    end
  end

  describe 'download' do
    it 'return the complete path in the download folder' do
      # Given
      input = 'foo.html'

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{data/html/foo.html$})
    end

    it 'keeps the directory structure' do
      # Given
      input = 'foo/bar.html'

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{data/html/foo/bar.html$})
    end

    it 'adds an html prefix if none is found' do
      # Given
      input = 'bar'

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{data/html/bar.html$})
    end

    it 'set to index.html is no path given' do
      # Given
      input = ''

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{/index.html$})
    end
  end
end
