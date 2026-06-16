import "./common.tsp";

namespace BookingApi;

/**
 * Тип события — шаблон встречи, который публикует владелец
 * (напр. «Знакомство 15 мин», «Консультация 60 мин»).
 * Длительность типа определяет нарезку доступных слотов.
 */
model EventType {
  /** Идентификатор типа события. */
  @key id: string;

  /** Название типа события. */
  name: string;

  /** Длительность встречи в минутах. */
  @minValue(1)
  durationMinutes: int32;

  /** Описание для гостя. */
  description?: string;

  /**
   * Активен ли тип. Неактивные (`false`) скрыты от гостя — это «архивация»
   * вместо удаления, чтобы не ломать ранее созданные брони.
   */
  active: boolean;
}

/** Данные для создания типа события. `active` по умолчанию `true`. */
model EventTypeCreate {
  name: string;

  @minValue(1)
  durationMinutes: int32;

  description?: string;
}

/** Данные для частичного обновления типа события (PATCH). */
model EventTypeUpdate {
  name?: string;

  @minValue(1)
  durationMinutes?: int32;

  description?: string;

  /** Перевод в архив/из архива. */
  active?: boolean;
}
