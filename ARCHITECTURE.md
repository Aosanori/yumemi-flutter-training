# 状態管理の構造
```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px;
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px;
  end
  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end

  weatherPageViewModelProvider[["weatherPageViewModelProvider"]];
  weatherDataSourceProvider[["weatherDataSourceProvider"]];
  yumemiWeatherServiceProvider[["yumemiWeatherServiceProvider"]];
  weatherRepositoryProvider[["weatherRepositoryProvider"]];
  WeatherInformation((WeatherInformation));
  WeatherPage((WeatherPage));

  weatherPageViewModelProvider ==> WeatherInformation;
  weatherPageViewModelProvider --> WeatherInformation;
  weatherPageViewModelProvider -.-> WeatherPage;
  yumemiWeatherServiceProvider ==> weatherDataSourceProvider;
  weatherDataSourceProvider ==> weatherRepositoryProvider;
```

# クリーンアーキテクチャとの対応
```mermaid
flowchart TB
 subgraph External Interfaces
    subgraph Controllers
      WeatherPageViewModel
      subgraph UseCases
        WeatherRepository
        subgraph Entities
          WeatherData
        end
      end
    end
    YumemiWeatherService
    WeatherDataSource
    WeatherPage
  end

  WeatherDataSource ..-> YumemiWeatherService
  WeatherRepository ..-> WeatherDataSource
  WeatherRepository ..-> WeatherData
  WeatherPageViewModel ..-> WeatherRepository
  WeatherPage ..-> WeatherPageViewModel

  subgraph Arrows

    start1[ ] ..-> | Dependency | stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    
  end
```